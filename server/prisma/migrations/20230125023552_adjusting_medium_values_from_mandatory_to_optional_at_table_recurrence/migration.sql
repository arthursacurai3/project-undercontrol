-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_recurrencies" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "frequency" TEXT NOT NULL,
    "repeat_every" INTEGER NOT NULL DEFAULT 1,
    "repeat_when_id" TEXT,
    "end_date" DATETIME,
    "end_after_repeated_times" INTEGER,
    "medium_value_id" TEXT,
    CONSTRAINT "recurrencies_repeat_when_id_fkey" FOREIGN KEY ("repeat_when_id") REFERENCES "RepeatDay" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "recurrencies_medium_value_id_fkey" FOREIGN KEY ("medium_value_id") REFERENCES "MediumValues" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_recurrencies" ("end_after_repeated_times", "end_date", "frequency", "id", "medium_value_id", "repeat_every", "repeat_when_id") SELECT "end_after_repeated_times", "end_date", "frequency", "id", "medium_value_id", "repeat_every", "repeat_when_id" FROM "recurrencies";
DROP TABLE "recurrencies";
ALTER TABLE "new_recurrencies" RENAME TO "recurrencies";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
