/*
  Warnings:

  - You are about to drop the `RepeatDay` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `repeat_when_id` on the `recurrencies` table. All the data in the column will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "RepeatDay";
PRAGMA foreign_keys=on;

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_recurrencies" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "frequency" TEXT NOT NULL,
    "repeat_every" INTEGER NOT NULL DEFAULT 1,
    "repeat_when" TEXT,
    "end_date" DATETIME,
    "end_after_repeated_times" INTEGER,
    "medium_value" REAL,
    "medium_tax" REAL
);
INSERT INTO "new_recurrencies" ("end_after_repeated_times", "end_date", "frequency", "id", "medium_tax", "medium_value", "repeat_every") SELECT "end_after_repeated_times", "end_date", "frequency", "id", "medium_tax", "medium_value", "repeat_every" FROM "recurrencies";
DROP TABLE "recurrencies";
ALTER TABLE "new_recurrencies" RENAME TO "recurrencies";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
