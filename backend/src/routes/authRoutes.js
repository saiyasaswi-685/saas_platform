const express = require('express');
const router = express.Router();
const { registerTenant, login, getMe, logout } = require('../controllers/authController');
const { verifyToken } = require('../middleware/authMiddleware');
const { check } = require('express-validator');

// Validation Middleware
const registerValidation = [
    check('tenantName', 'Tenant Name is required').not().isEmpty(),
    check('subdomain', 'Subdomain is required').not().isEmpty(),
    check('adminEmail', 'Please include a valid email').isEmail(),
    check('adminPassword', 'Password must be 8 or more characters').isLength({ min: 8 })
];

router.post('/register-tenant', registerValidation, registerTenant);
router.post('/login', login);
router.get('/me', verifyToken, getMe);
router.post('/logout', verifyToken, logout);

module.exports = router;