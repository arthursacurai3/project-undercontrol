/*
  Warnings:

  - You are about to drop the column `repeat` on the `recurrencies` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "RepeatDay" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "day_of_month" INTEGER,
    "day_of_week" INTEGER,
    "week_of_month" INTEGER
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_recurrencies" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "frequency" TEXT NOT NULL,
    "repeat_every" INTEGER NOT NULL DEFAULT 1,
    "repeat_when" TEXT,
    "end_date" DATETIME,
    "end_after_repeated_times" INTEGER,
    CONSTRAINT "recurrencies_repeat_when_fkey" FOREIGN KEY ("repeat_when") REFERENCES "RepeatDay" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_recurrencies" ("frequency", "id", "repeat_every", "repeat_when") SELECT "frequency", "id", "repeat_every", "repeat_when" FROM "recurrencies";
DROP TABLE "recurrencies";
ALTER TABLE "new_recurrencies" RENAME TO "recurrencies";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
