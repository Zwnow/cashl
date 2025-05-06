<script setup>
import OtherComponent from '../components/OtherComponent.vue'
import { useSomeStore } from '../stores/someStore.js';

const someStore = useSomeStore();
</script>

<template>
    <main class="inset-0 absolute flex flex-col justify-center items-center">
        <button 
            @click="() => someStore.somefunc()"
            class="border border-black p-2 rounded-md">Increment</button>
        <div>This component count: {{someStore.count}}</div>
        <OtherComponent />
    </main>
</template>
