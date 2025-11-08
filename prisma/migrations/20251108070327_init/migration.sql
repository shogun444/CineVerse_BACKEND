-- CreateTable
CREATE TABLE "TVSeries" (
    "id" SERIAL NOT NULL,
    "tmdbId" INTEGER NOT NULL,
    "chat_id" TEXT NOT NULL,
    "popularity" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "language" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "genre" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "overview" TEXT,
    "posterPath" TEXT,
    "releaseDate" TEXT,
    "rating" TEXT,

    CONSTRAINT "TVSeries_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Season" (
    "id" SERIAL NOT NULL,
    "seasonNumber" INTEGER NOT NULL,
    "chat_id" TEXT NOT NULL,
    "tmdbId" INTEGER,
    "overview" TEXT,
    "seriesId" INTEGER NOT NULL,

    CONSTRAINT "Season_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Episode" (
    "id" SERIAL NOT NULL,
    "episodeNumber" INTEGER NOT NULL,
    "tmdbEpisodeId" INTEGER NOT NULL,
    "chat_id" TEXT NOT NULL,
    "file_id" TEXT NOT NULL,
    "title" TEXT,
    "overview" TEXT,
    "filesize" TEXT DEFAULT '',
    "airDate" TIMESTAMP(3),
    "runtime" INTEGER,
    "message_id" INTEGER,
    "telegramLink" TEXT,
    "stillPath" TEXT,
    "seasonId" INTEGER NOT NULL,

    CONSTRAINT "Episode_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "TVSeries_tmdbId_key" ON "TVSeries"("tmdbId");

-- CreateIndex
CREATE UNIQUE INDEX "Season_seriesId_seasonNumber_key" ON "Season"("seriesId", "seasonNumber");

-- CreateIndex
CREATE INDEX "Episode_tmdbEpisodeId_idx" ON "Episode"("tmdbEpisodeId");

-- CreateIndex
CREATE INDEX "Episode_seasonId_episodeNumber_idx" ON "Episode"("seasonId", "episodeNumber");

-- AddForeignKey
ALTER TABLE "Season" ADD CONSTRAINT "Season_seriesId_fkey" FOREIGN KEY ("seriesId") REFERENCES "TVSeries"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Episode" ADD CONSTRAINT "Episode_seasonId_fkey" FOREIGN KEY ("seasonId") REFERENCES "Season"("id") ON DELETE CASCADE ON UPDATE CASCADE;
