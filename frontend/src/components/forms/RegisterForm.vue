<script setup>
import { ref } from 'vue';

/**
 * @param { SubmitEvent } e
 * @param { Object } body
 * @param { string } body.email
 * @param { string } body.password
 * @param { string } body.passwordConfirm
 */
const onSubmit = async (e) => {
    if (!validateForm()) return;
    try {
        const response = await fetch('http://127.0.0.1:4000/api/users/register', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({user: form.value}),
        });
        const data = await response.json();
        if (response.ok) {
            // Add success callback or redirect
            resetForm();
        } else {
            console.error('Server error:', data);
        }
    } catch(error) {
        console.error('Network error:', error);
    }
}

const errors = ref({
    email: '',
    password: '',
    passwordConfirm: '',
});

const resetForm = () => {
    form.value = {
        email: '',
        password: '',
        passwordConfirm: '',
    };
    errors.value = {
        email: '',
        password: '',
        passwordConfirm: '',
    };
}

/**
 * @typedef {Object} FormData
 * @property {string} email
 * @property {string} password
 * @property {string} passwordConfirm
 */
const form = ref({
    email: '',
    password: '',
    passwordConfirm: '',
});

/**
 * @returns boolean
 */
const validateForm = () => {
    let isValid = true;
    errors.value = {
        email: '',
        password: '',
        passwordConfirm: '',
    };

    // Basic email check
    if (!form.value.email) {
        errors.value.email = 'Email is required.';
        isValid = false;
    } else if (!/^\S+@\S+\.\S+$/.test(form.value.email)) {
        errors.value.email = 'Email is invalid.';
        isValid = false;
    }

    // Password check
    if (!form.value.password) {
        errors.value.password = 'Password is required.';
        isValid = false;
    } else if (form.value.password.length < 8) {
        errors.value.password = 'Password must be at least 8 characters.';
        isValid = false;
    }

    // Confirm password check
    if (!form.value.passwordConfirm) {
        errors.value.passwordConfirm = 'Please confirm your password.';
        isValid = false;
    } else if (form.value.password !== form.value.passwordConfirm) {
        errors.value.passwordConfirm = 'Passwords do not match.';
        isValid = false;
    }

    return isValid;
}
</script>

<template>
    <form @submit.prevent="(e) => onSubmit(e)" role="form" aria-labelledby="registration-form-title">
        <h2 id="registration-form-title" class="sr-only">Register</h2>

        <fieldset class="flex flex-col gap-2">
            <label for="email">E-Mail</label>
            <input id="email" type="email" v-model="form.email" required aria-required="true"
                :aria-invalid="!!errors.email" :aria-describedby="errors.email ? 'email-error' : null"
                autocomplete="email">
            <span v-if="errors.email" id="email-error" class="text-red-500 text-xs" role="alert">
                {{ errors.email }}
            </span>
        </fieldset>

        <fieldset class="flex flex-col gap-2">
            <label for="password">Password</label>
            <input id="password" type="password" v-model="form.password" required aria-required="true"
                :aria-invalid="!!errors.password" :aria-describedby="errors.password ? 'password-error' : null"
                autocomplete="new-password">
            <span v-if="errors.password" id="password-error" class="text-red-500 text-xs" role="alert">
                {{ errors.password }}
            </span>
        </fieldset>

        <fieldset class="flex flex-col gap-2">
            <label for="confirm_password">Confirm Password</label>
            <input id="confirm_password" type="password" v-model="form.passwordConfirm" required aria-required="true"
                :aria-invalid="!!errors.passwordConfirm"
                :aria-describedby="errors.passwordConfirm ? 'confirm-password-error' : null"
                autocomplete="new-password">
            <span v-if="errors.passwordConfirm" id="confirm-password-error" class="text-red-500 text-xs" role="alert">
                {{ errors.passwordConfirm }}
            </span>
        </fieldset>

        <button type="submit">Register</button>
    </form>
</template>