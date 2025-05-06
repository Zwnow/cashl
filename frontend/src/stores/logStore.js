import { defineStore } from 'pinia';
import { ref } from 'vue';

export const useLogStore = defineStore('logs', () => {
    const MAX_SIZE = 500;

    let start = 0;
    let end = 0;
    let size = 0;

    const logs = ref(Array(MAX_SIZE).fill(null));

    const log = (message) => {
        logs.value[end] = message;
        end = (end + 1) % MAX_SIZE;

        if (size < MAX_SIZE) {
            size += 1;
        } else {
            start = (start + 1) % MAX_SIZE
        }
    }

    const readLogs = () => {
        const localLogs = [];
        for (let i = 0; i < size; i++) {
            const index = (start + i) % MAX_SIZE;
            logs.push(logs.value[index]);
        }
        return localLogs;
    }
});