import {defineStore} from 'pinia';
import {ref} from 'vue';

export const useSomeStore = defineStore('somestore', () => {
    const count = ref(0);

    const somefunc = async () => {
        await fetch("http://127.0.0.1:4000/users/register", {
            method: "POST",
            headers: {
                'Content-Type': 'application/json'
            }
        })
    }

    return {count, somefunc};
})
