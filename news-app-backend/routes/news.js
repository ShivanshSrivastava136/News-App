const express = require('express');
const axios = require('axios');
const router = express.Router();

const API_KEY = process.env.NEWS_API_KEY;
const BASE_URL = 'https://newsapi.org/v2';

// Get trending news
router.get('/trending', async (req, res) => {
  try {
    const response = await axios.get(`${BASE_URL}/top-headlines`, {
      params: {
        country: 'us',
        apiKey: API_KEY,
        pageSize: 20
      }
    });
    res.json(response.data);
  } catch (error) {
    console.error('Error fetching trending news:', error);
    res.status(500).json({ error: 'Failed to fetch news' });
  }
});

// Get news by category
router.get('/category/:category', async (req, res) => {
  try {
    const { category } = req.params;
    const response = await axios.get(`${BASE_URL}/top-headlines`, {
      params: {
        country: 'us',
        category,
        apiKey: API_KEY,
        pageSize: 20
      }
    });
    res.json(response.data);
  } catch (error) {
    console.error(`Error fetching ${req.params.category} news:`, error);
    res.status(500).json({ error: 'Failed to fetch news by category' });
  }
});

// Search news
router.get('/search', async (req, res) => {
  try {
    const { query } = req.query;
    const response = await axios.get(`${BASE_URL}/everything`, {
      params: {
        q: query,
        apiKey: API_KEY,
        pageSize: 20,
        sortBy: 'relevancy'
      }
    });
    res.json(response.data);
  } catch (error) {
    console.error('Error searching news:', error);
    res.status(500).json({ error: 'Failed to search news' });
  }
});

module.exports = router;