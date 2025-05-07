<script setup>
import RegisterForm from '@/components/forms/RegisterForm.vue';
import OtherComponent from '../components/OtherComponent.vue'
import { useSomeStore } from '../stores/someStore.js';

const someStore = useSomeStore();
</script>

<template>
    <main class="inset-0 absolute flex flex-col justify-center items-center">
        <RegisterForm></RegisterForm>
    </main>
</template>
