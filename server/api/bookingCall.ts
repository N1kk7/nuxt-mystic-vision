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

    switch(method) {
        case "GET":

            if (query.method === "getAvailableSlots") {
                return await getAvailableSlots(offset);
            } else if (query.method === "getAllCallbacks") {
                return await getAllCallbacks(offset);
            }

        break;
        case "POST":

            if(query.method === "addCallback") {
                return await addCallback(event);
            } else if (query.method === "reserveSlot") {
                return await reserveSlot(event);
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