/*
  Warnings:

  - You are about to drop the column `contact` on the `Callback` table. All the data in the column will be lost.
  - You are about to drop the column `testing` on the `Callback` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[email]` on the table `Callback` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `email` to the `Callback` table without a default value. This is not possible if the table is not empty.
  - Added the required column `phone` to the `Callback` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "public"."ContactMethod" AS ENUM ('PHONE_CALL', 'GOOGLE_MEET', 'SOMEWHERE_ELSE');

-- AlterTable
ALTER TABLE "public"."Callback" DROP COLUMN "contact",
DROP COLUMN "testing",
ADD COLUMN     "comment" TEXT,
ADD COLUMN     "contactMethod" "public"."ContactMethod" NOT NULL DEFAULT 'GOOGLE_MEET',
ADD COLUMN     "email" TEXT NOT NULL,
ADD COLUMN     "phone" TEXT NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Callback_email_key" ON "public"."Callback"("email");
