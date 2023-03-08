/*
  Warnings:

  - You are about to drop the column `definition` on the `methods` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_methods" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "bank" TEXT
);
INSERT INTO "new_methods" ("id", "name") SELECT "id", "name" FROM "methods";
DROP TABLE "methods";
ALTER TABLE "new_methods" RENAME TO "methods";
CREATE UNIQUE INDEX "methods_name_key" ON "methods"("name");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
