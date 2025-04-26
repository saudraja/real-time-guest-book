<template>
  <div>
    <div v-for="comment in comments" :key="comment.id" class="comment">
      <strong>{{ comment.name }}</strong>: {{ comment.message }}
    </div>
  </div>
</template>

<script setup>
defineProps(['comments']);
</script>

<style scoped>
.comment {
  margin-bottom: 1rem;
  padding: 0.5rem;
  border-bottom: 1px solid #ccc;
}
</style>
