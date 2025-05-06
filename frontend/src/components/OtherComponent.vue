<script setup>
import { useSomeStore } from '../stores/someStore.js';

const someStore = useSomeStore();
</script>

<template>
    <div>Other component count: {{someStore.count}}</div>
</template>
