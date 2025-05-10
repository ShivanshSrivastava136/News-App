const express = require('express');
const router = express.Router();
const Favorite = require('../models/Favorite');

// Get user favorites
router.get('/:userId', async (req, res) => {
  try {
    const { userId } = req.params;
    const favorites = await Favorite.find({ userId });
    res.json(favorites);
  } catch (error) {
    console.error('Error fetching favorites:', error);
    res.status(500).json({ error: 'Failed to fetch favorites' });
  }
});

// Add to favorites
router.post('/', async (req, res) => {
  try {
    const { userId, article } = req.body;

    // Check if already exists
    const existing = await Favorite.findOne({
      userId,
      'article.url': article.url
    });

    if (existing) {
      return res.status(400).json({ error: 'Article already in favorites' });
    }

    const favorite = new Favorite({
      userId,
      article
    });

    await favorite.save();
    res.status(201).json(favorite);
  } catch (error) {
    console.error('Error adding to favorites:', error);
    res.status(500).json({ error: 'Failed to add to favorites' });
  }
});

// Remove from favorites
router.delete('/:userId/:articleId', async (req, res) => {
  try {
    const { userId, articleId } = req.params;
    await Favorite.findByIdAndDelete(articleId);
    res.json({ success: true });
  } catch (error) {
    console.error('Error removing from favorites:', error);
    res.status(500).json({ error: 'Failed to remove from favorites' });
  }
});

module.exports = router;