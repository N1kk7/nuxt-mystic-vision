/*
  Warnings:

  - The values [test] on the enum `SubscriptionPlanStatus` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "public"."SubscriptionPlanStatus_new" AS ENUM ('active', 'deactivate');
ALTER TABLE "public"."SubscriptionPlan" ALTER COLUMN "subStatus" TYPE "public"."SubscriptionPlanStatus_new" USING ("subStatus"::text::"public"."SubscriptionPlanStatus_new");
ALTER TYPE "public"."SubscriptionPlanStatus" RENAME TO "SubscriptionPlanStatus_old";
ALTER TYPE "public"."SubscriptionPlanStatus_new" RENAME TO "SubscriptionPlanStatus";
DROP TYPE "public"."SubscriptionPlanStatus_old";
COMMIT;
