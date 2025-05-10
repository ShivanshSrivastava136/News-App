const mongoose = require('mongoose');

const FavoriteSchema = new mongoose.Schema({
  userId: {
    type: String,
    required: true,
  },
  article: {
    source: {
      id: String,
      name: String
    },
    author: String,
    title: {
      type: String,
      required: true
    },
    description: String,
    url: {
      type: String,
      required: true
    },
    urlToImage: String,
    publishedAt: String,
    content: String
  },
  addedAt: {
    type: Date,
    default: Date.now
  }
});

// Create a compound index to prevent duplicates
FavoriteSchema.index({ userId: 1, 'article.url': 1 }, { unique: true });

module.exports = mongoose.model('Favorite', FavoriteSchema);