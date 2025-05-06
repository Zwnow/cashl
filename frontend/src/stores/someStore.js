import {defineStore} from 'pinia';
import {ref} from 'vue';

export const useSomeStore = defineStore('somestore', () => {
    const count = ref(0);

    return {count};
})
