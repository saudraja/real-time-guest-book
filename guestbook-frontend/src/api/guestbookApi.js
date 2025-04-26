import axios from 'axios';

const API_BASE_URL = 'http://localhost:3000';

const api = axios.create({
  baseURL: API_BASE_URL,
});

export const getComments = () => api.get('/comments');
export const postComment = (data) => api.post('/comments', data);

export const getAdminComments = (token) => api.get('/admin/comments', {
  headers: { Authorization: `Bearer ${token}` },
});
export const markCommentAsSpam = (id, token) => api.patch(`/admin/comments/${id}/mark_spam`, null, {
  headers: { Authorization: `Bearer ${token}` },
});
export const deleteComment = (id, token) => api.delete(`/admin/comments/${id}`, {
  headers: { Authorization: `Bearer ${token}` },
});
