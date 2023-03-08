/*
  Warnings:

  - Added the required column `entityId` to the `registers` table without a default value. This is not possible if the table is not empty.
  - Added the required column `entity_id` to the `registers` table without a default value. This is not possible if the table is not empty.
  - Added the required column `methodId` to the `registers` table without a default value. This is not possible if the table is not empty.
  - Added the required column `method_id` to the `registers` table without a default value. This is not possible if the table is not empty.
  - Added the required column `recurrenceId` to the `registers` table without a default value. This is not possible if the table is not empty.
  - Added the required column `recurrence_id` to the `registers` table without a default value. This is not possible if the table is not empty.
  - Added the required column `typeId` to the `registers` table without a default value. This is not possible if the table is not empty.
  - Added the required column `type_id` to the `registers` table without a default value. This is not possible if the table is not empty.

*/
-- CreateTable
CREATE TABLE "entities" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "definition" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "types" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "methods" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "definition" TEXT
);

-- CreateTable
CREATE TABLE "recurrencies" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "frequency" TEXT NOT NULL,
    "repeat" INTEGER NOT NULL DEFAULT 1,
    "repeat_every" INTEGER NOT NULL DEFAULT 1,
    "repeat_when" TEXT NOT NULL
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_registers" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "value" REAL NOT NULL,
    "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "entity_id" TEXT NOT NULL,
    "type_id" TEXT NOT NULL,
    "method_id" TEXT NOT NULL,
    "recurrence_id" TEXT NOT NULL,
    CONSTRAINT "registers_entity_id_fkey" FOREIGN KEY ("entity_id") REFERENCES "entities" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "registers_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "types" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "registers_method_id_fkey" FOREIGN KEY ("method_id") REFERENCES "methods" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "registers_recurrence_id_fkey" FOREIGN KEY ("recurrence_id") REFERENCES "recurrencies" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_registers" ("date", "description", "id", "name", "value") SELECT "date", "description", "id", "name", "value" FROM "registers";
DROP TABLE "registers";
ALTER TABLE "new_registers" RENAME TO "registers";
CREATE UNIQUE INDEX "registers_entity_id_type_id_method_id_recurrence_id_key" ON "registers"("entity_id", "type_id", "method_id", "recurrence_id");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "entities_name_key" ON "entities"("name");

-- CreateIndex
CREATE UNIQUE INDEX "types_name_key" ON "types"("name");

-- CreateIndex
CREATE UNIQUE INDEX "methods_name_key" ON "methods"("name");
