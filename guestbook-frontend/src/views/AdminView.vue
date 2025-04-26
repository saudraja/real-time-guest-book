<template>
  <div class="admin-container">
    <h1>Admin Dashboard</h1>

    <div v-if="!token">
      <form @submit.prevent="login">
        <input v-model="email" placeholder="Admin Email" class="admin-input" required />
        <input v-model="password" type="password" placeholder="Password" class="admin-input" required />
        <button type="submit" class="admin-button">Login</button>
      </form>
    </div>

    <div v-else>
      <button @click="logout" class="admin-button logout">Logout</button>

      <div class="admin-list">
        <div v-for="entry in entries" :key="entry.id" class="admin-entry">
          <div>
            <strong>{{ entry.name }}</strong>: {{ entry.message }}
            <div v-if="entry.is_spam" class="spam-label">(Spam)</div>
          </div>
          <div class="admin-actions">
            <button @click="markSpam(entry.id)" :disabled="entry.is_spam" class="admin-button small">Mark Spam</button>
            <button @click="deleteEntry(entry.id)" class="admin-button small delete">Delete</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import axios from 'axios';
import cable from '../cable';
import { getAdminComments, markCommentAsSpam, deleteComment } from '../api/guestbookApi';
let subscription = null;

const email = ref('');
const password = ref('');
const token = ref(null);
const entries = ref([]);

const subscribeToNewComments = () => {
  cable.subscriptions.create('GuestbookEntriesChannel', {
    received(entry) {
      console.log('New entry received in Admin Panel:', entry);
      entries.value.unshift(entry);
      if (entries.value.length > 50) {
        entries.value.pop();
      }
    }
  });
};


const login = async () => {
  try {
    const { data } = await axios.post('http://localhost:3000/admin/login', {
      email: email.value,
      password: password.value
    });
    token.value = data.token;
    fetchEntries();
    subscribeToNewComments(); 
  } catch (error) {
    console.error('Login failed', error);
    alert('Invalid email or password');
  }
};

const fetchEntries = async () => {
  try {
    const { data } = await getAdminComments(token.value);
    entries.value = data;
  } catch (error) {
    console.error('Failed to fetch entries', error);
    logout();
  }
};

const logout = () => {
  token.value = null;
  email.value = '';
  password.value = '';
  entries.value = [];
};

const markSpam = async (id) => {
  await markCommentAsSpam(id, token.value);
  fetchEntries();
};

const deleteEntry = async (id) => {
  await deleteComment(id, token.value);
  fetchEntries();
};
</script>

<style scoped>
.admin-container {
  max-width: 700px;
  margin: 2rem auto;
  padding: 1rem;
}

.admin-input {
  padding: 0.75rem;
  margin-bottom: 1rem;
  width: 100%;
  border-radius: 8px;
  border: 1px solid #ccc;
}

.admin-button {
  background-color: #646cff;
  color: white;
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 8px;
  margin-top: 0.5rem;
  cursor: pointer;
}

.admin-button:hover {
  background-color: #4a50cc;
}

.logout {
  background-color: #ff4d4d;
  margin-bottom: 1rem;
}

.logout:hover {
  background-color: #cc0000;
}

.admin-list {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.admin-entry {
  border: 1px solid #ddd;
  padding: 1rem;
  border-radius: 8px;
  background: #f5f5f5;
  color: #111;
}

.admin-actions {
  margin-top: 0.5rem;
  display: flex;
  gap: 0.5rem;
}

.admin-button.small {
  padding: 0.25rem 0.5rem;
  font-size: 0.9rem;
}

.admin-button.delete {
  background-color: #ff4d4d;
}

.admin-button.delete:hover {
  background-color: #cc0000;
}

</style>