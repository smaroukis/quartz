> “[One] who works with the door open gets all kinds of interruptions, but [they] also occasionally gets clues as to what the world is and what might be important.” — Richard Hamming

This [Quartz](https://quartz.jzhao.xyz/) fork is for publishing my Today I Learned blog at <https://til.maroukis.net>. It's meant to be a low barrier way to publish micro blog posts about what I'm working on, which works with my notetaking editor of choice [Obsidian](https://obsidian.md).


## Notes to Self

**Organization**
- Source markdown files are in `/content`. 
- `_userscripts/prebuild.sh` builds a custom index.md page of recent notes
- For updating Quartz checkout the `v4` branch and merge upstream changes into `main`. 

### Building
- build and deploy is performed via the `.github/workflows/deploy.yml` file which deploys using the actions/deploy-pages@v2 to deploy via Actions (must be set in the repo settings)
- can be built and served locally using `_userscripts/prebuild.sh`

### Quartz Configuration
Configure in `quartz.config.ts`.

**Excluded folders and files**:
- edit in `quartz.config.ts` e.g. `ignorePatterns: ["private", "Templates", ".obsidian", "Utilities"]`
- edit the `_userscripts/makeindex.sh` file exclude patterns
- edit in `.gitignore` 