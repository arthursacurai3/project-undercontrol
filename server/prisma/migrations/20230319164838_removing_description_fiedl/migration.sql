/*
  Warnings:

  - You are about to drop the column `description` on the `registers` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_registers" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "value" REAL NOT NULL,
    "pending" BOOLEAN NOT NULL DEFAULT true,
    "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "type_id" TEXT,
    "category_id" TEXT,
    "method_id" TEXT,
    "recurrence_id" INTEGER,
    CONSTRAINT "registers_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "types" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "registers_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "categories" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "registers_method_id_fkey" FOREIGN KEY ("method_id") REFERENCES "methods" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "registers_recurrence_id_fkey" FOREIGN KEY ("recurrence_id") REFERENCES "recurrencies" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_registers" ("category_id", "date", "id", "method_id", "recurrence_id", "title", "type_id", "value") SELECT "category_id", "date", "id", "method_id", "recurrence_id", "title", "type_id", "value" FROM "registers";
DROP TABLE "registers";
ALTER TABLE "new_registers" RENAME TO "registers";
CREATE UNIQUE INDEX "registers_recurrence_id_key" ON "registers"("recurrence_id");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
