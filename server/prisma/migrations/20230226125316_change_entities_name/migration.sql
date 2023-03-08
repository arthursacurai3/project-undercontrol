/*
  Warnings:

  - You are about to drop the `entities` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `entity_id` on the `registers` table. All the data in the column will be lost.
  - Added the required column `definition` to the `types` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "entities_name_key";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "entities";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "categories" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_registers" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "value" REAL NOT NULL,
    "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "type_id" TEXT,
    "category_id" TEXT,
    "method_id" TEXT,
    "recurrence_id" INTEGER,
    CONSTRAINT "registers_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "types" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "registers_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "categories" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "registers_method_id_fkey" FOREIGN KEY ("method_id") REFERENCES "methods" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "registers_recurrence_id_fkey" FOREIGN KEY ("recurrence_id") REFERENCES "recurrencies" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_registers" ("date", "description", "id", "method_id", "recurrence_id", "title", "type_id", "value") SELECT "date", "description", "id", "method_id", "recurrence_id", "title", "type_id", "value" FROM "registers";
DROP TABLE "registers";
ALTER TABLE "new_registers" RENAME TO "registers";
CREATE UNIQUE INDEX "registers_recurrence_id_key" ON "registers"("recurrence_id");
CREATE TABLE "new_types" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "definition" TEXT NOT NULL
);
INSERT INTO "new_types" ("id", "name") SELECT "id", "name" FROM "types";
DROP TABLE "types";
ALTER TABLE "new_types" RENAME TO "types";
CREATE UNIQUE INDEX "types_name_key" ON "types"("name");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "categories_name_key" ON "categories"("name");
