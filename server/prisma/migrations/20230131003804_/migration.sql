/*
  Warnings:

  - The primary key for the `recurrencies` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `recurrencies` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - You are about to alter the column `recurrence_id` on the `registers` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_recurrencies" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "frequency" TEXT NOT NULL,
    "repeat_every" INTEGER NOT NULL DEFAULT 1,
    "repeat_when" TEXT,
    "end_date" DATETIME,
    "end_after_repeated_times" INTEGER,
    "medium_value" REAL,
    "medium_tax" REAL
);
INSERT INTO "new_recurrencies" ("end_after_repeated_times", "end_date", "frequency", "id", "medium_tax", "medium_value", "repeat_every", "repeat_when") SELECT "end_after_repeated_times", "end_date", "frequency", "id", "medium_tax", "medium_value", "repeat_every", "repeat_when" FROM "recurrencies";
DROP TABLE "recurrencies";
ALTER TABLE "new_recurrencies" RENAME TO "recurrencies";
CREATE TABLE "new_registers" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "value" REAL NOT NULL,
    "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "entity_id" TEXT,
    "type_id" TEXT,
    "method_id" TEXT,
    "recurrence_id" INTEGER,
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
