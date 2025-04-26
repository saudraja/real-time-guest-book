<template>
  <div>
    <h1>Guestbook</h1>

    <GuestbookForm @new-comment="addComment" />
    <GuestbookList :comments="comments" />
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import GuestbookForm from '../components/GuestbookForm.vue';
import GuestbookList from '../components/GuestbookList.vue';
import { getComments } from '../api/guestbookApi';
import cable from '../cable';

let subscription = null;  // Track subscription globally

const comments = ref([]);

// Fetch all initial comments
const fetchComments = async () => {
  const { data } = await getComments();
  comments.value = data;
};

// Add a new comment to top
const addComment = (comment) => {
  comments.value.unshift(comment);
  if (comments.value.length > 50) {
    comments.value.pop(); // Keep memory safe
  }
};

// Subscribe to WebSocket channel
const subscribeToGuestbookChannel = () => {
  if (subscription) {
    subscription.unsubscribe();
  }

  subscription = cable.subscriptions.create('GuestbookEntriesChannel', {
    received(comment) {
      addComment(comment);
    }
  });
};

onMounted(() => {
  fetchComments();
  subscribeToGuestbookChannel();
});

onUnmounted(() => {
  if (subscription) {
    subscription.unsubscribe();
    subscription = null;
  }
});

</script>
