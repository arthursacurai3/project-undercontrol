/*
  Warnings:

  - A unique constraint covering the columns `[name,bank]` on the table `methods` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "methods_name_key";

-- CreateIndex
CREATE UNIQUE INDEX "methods_name_bank_key" ON "methods"("name", "bank");
