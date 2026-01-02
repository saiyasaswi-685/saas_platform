const express = require('express');
const router = express.Router();
const { createProject, listProjects, updateProject, deleteProject } = require('../controllers/projectController');
const { verifyToken } = require('../middleware/authMiddleware');
const { check } = require('express-validator');

// Create
router.post('/', 
    verifyToken,
    [check('name', 'Project name is required').not().isEmpty()],
    createProject
);

// List
router.get('/', verifyToken, listProjects);

// Update
router.put('/:projectId', verifyToken, updateProject);

// Delete
router.delete('/:projectId', verifyToken, deleteProject);

module.exports = router;