<template>
  <form @submit.prevent="submitComment" class="guestbook-form">
    <input v-model="name" placeholder="Your Name" class="guestbook-input" required />
    <textarea v-model="message" placeholder="Your Message" class="guestbook-textarea" required></textarea>
    <button type="submit" class="guestbook-button">Submit</button>
  </form>
</template>

<script setup>
import { ref } from 'vue';
import { postComment } from '../api/guestbookApi';

const emit = defineEmits(['new-comment']);
const name = ref('');
const message = ref('');

const submitComment = async () => {
  if (!name.value.trim() || !message.value.trim()) return;

  const { data } = await postComment({ name: name.value, message: message.value });

  name.value = '';
  message.value = '';
};
</script>

<style scoped>
.guestbook-form {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  margin-bottom: 2rem;
  max-width: 600px;
  margin-left: auto;
  margin-right: auto;
}

.guestbook-input, .guestbook-textarea {
  padding: 0.75rem 1rem;
  font-size: 1rem;
  border: 1px solid #ccc;
  border-radius: 8px;
  background-color: #f9f9f9;
  color: #111;
  width: 100%;
}

.guestbook-textarea {
  min-height: 100px;
}

.guestbook-button {
  background-color: #646cff;
  color: white;
  padding: 0.75rem 1rem;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-weight: bold;
  transition: background-color 0.3s;
}

.guestbook-button:hover {
  background-color: #4a50cc;
}
</style>
