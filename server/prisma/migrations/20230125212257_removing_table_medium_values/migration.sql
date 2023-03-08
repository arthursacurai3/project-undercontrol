/*
  Warnings:

  - You are about to drop the `MediumValues` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `medium_value_id` on the `recurrencies` table. All the data in the column will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "MediumValues";
PRAGMA foreign_keys=on;

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_recurrencies" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "frequency" TEXT NOT NULL,
    "repeat_every" INTEGER NOT NULL DEFAULT 1,
    "repeat_when_id" TEXT,
    "end_date" DATETIME,
    "end_after_repeated_times" INTEGER,
    "medium_value" REAL,
    "medium_tax" REAL,
    CONSTRAINT "recurrencies_repeat_when_id_fkey" FOREIGN KEY ("repeat_when_id") REFERENCES "RepeatDay" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_recurrencies" ("end_after_repeated_times", "end_date", "frequency", "id", "repeat_every", "repeat_when_id") SELECT "end_after_repeated_times", "end_date", "frequency", "id", "repeat_every", "repeat_when_id" FROM "recurrencies";
DROP TABLE "recurrencies";
ALTER TABLE "new_recurrencies" RENAME TO "recurrencies";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
