/*
  Warnings:

  - You are about to drop the column `repeat_when` on the `recurrencies` table. All the data in the column will be lost.
  - Added the required column `medium_value_id` to the `recurrencies` table without a default value. This is not possible if the table is not empty.

*/
-- CreateTable
CREATE TABLE "MediumValues" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "medium_value" REAL NOT NULL,
    "medium_tax" REAL
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_recurrencies" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "frequency" TEXT NOT NULL,
    "repeat_every" INTEGER NOT NULL DEFAULT 1,
    "repeat_when_id" TEXT,
    "end_date" DATETIME,
    "end_after_repeated_times" INTEGER,
    "medium_value_id" TEXT NOT NULL,
    CONSTRAINT "recurrencies_repeat_when_id_fkey" FOREIGN KEY ("repeat_when_id") REFERENCES "RepeatDay" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "recurrencies_medium_value_id_fkey" FOREIGN KEY ("medium_value_id") REFERENCES "MediumValues" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_recurrencies" ("end_after_repeated_times", "end_date", "frequency", "id", "repeat_every") SELECT "end_after_repeated_times", "end_date", "frequency", "id", "repeat_every" FROM "recurrencies";
DROP TABLE "recurrencies";
ALTER TABLE "new_recurrencies" RENAME TO "recurrencies";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
