import { defineEventHandler } from "#imports";

import {
    addCallback,
    getAvailableSlots,
    getAllCallbacks,
    reserveSlot
} from "../services/callbackServices";




export default defineEventHandler(async (event) => {

    const method = event.node.req.method;
    const query = getQuery(event);

    const offset = query.offset;

    console.log(query, "query");
    // return

    switch(method) {
        case "GET":

            if (query.method === "getAvailableSlots") {
                console.log(query.date)
                return await getAvailableSlots(query.date);
            } else if (query.method === "getAllCallbacks") {
                return await getAllCallbacks(offset);
            }

        break;
        case "POST":

            if(query.method === "addCallback") {
                return await addCallback(event);
            } else if (query.method === "reserveSlot") {
                // if (query.date && query.time){
                return await reserveSlot(query.date as string, query.time as string);
                // }
            }

        break;
        case "PUT":
        break;
        case "PATCH":
        break;
        case "DELETE":
        break;
    }

})