/*
  Warnings:

  - You are about to drop the column `entityId` on the `registers` table. All the data in the column will be lost.
  - You are about to drop the column `methodId` on the `registers` table. All the data in the column will be lost.
  - You are about to drop the column `recurrenceId` on the `registers` table. All the data in the column will be lost.
  - You are about to drop the column `typeId` on the `registers` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_registers" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "value" REAL NOT NULL,
    "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "entity_id" TEXT,
    "type_id" TEXT,
    "method_id" TEXT,
    "recurrence_id" TEXT,
    CONSTRAINT "registers_entity_id_fkey" FOREIGN KEY ("entity_id") REFERENCES "entities" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "registers_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "types" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "registers_method_id_fkey" FOREIGN KEY ("method_id") REFERENCES "methods" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "registers_recurrence_id_fkey" FOREIGN KEY ("recurrence_id") REFERENCES "recurrencies" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_registers" ("date", "description", "entity_id", "id", "method_id", "name", "recurrence_id", "type_id", "value") SELECT "date", "description", "entity_id", "id", "method_id", "name", "recurrence_id", "type_id", "value" FROM "registers";
DROP TABLE "registers";
ALTER TABLE "new_registers" RENAME TO "registers";
CREATE UNIQUE INDEX "registers_recurrence_id_key" ON "registers"("recurrence_id");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
