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
    "entityId" TEXT,
    "typeId" TEXT,
    "methodId" TEXT,
    "recurrenceId" TEXT,
    CONSTRAINT "registers_entity_id_fkey" FOREIGN KEY ("entity_id") REFERENCES "entities" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "registers_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "types" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "registers_method_id_fkey" FOREIGN KEY ("method_id") REFERENCES "methods" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "registers_recurrence_id_fkey" FOREIGN KEY ("recurrence_id") REFERENCES "recurrencies" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_registers" ("date", "description", "entityId", "entity_id", "id", "methodId", "method_id", "name", "recurrenceId", "recurrence_id", "typeId", "type_id", "value") SELECT "date", "description", "entityId", "entity_id", "id", "methodId", "method_id", "name", "recurrenceId", "recurrence_id", "typeId", "type_id", "value" FROM "registers";
DROP TABLE "registers";
ALTER TABLE "new_registers" RENAME TO "registers";
CREATE UNIQUE INDEX "registers_recurrence_id_key" ON "registers"("recurrence_id");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
