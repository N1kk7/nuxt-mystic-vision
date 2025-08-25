-- CreateTable
CREATE TABLE "public"."CallbackReservation" (
    "id" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "time" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "callbackId" TEXT,

    CONSTRAINT "CallbackReservation_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "public"."CallbackReservation" ADD CONSTRAINT "CallbackReservation_callbackId_fkey" FOREIGN KEY ("callbackId") REFERENCES "public"."Callback"("id") ON DELETE SET NULL ON UPDATE CASCADE;
