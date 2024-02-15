> “[One] who works with the door open gets all kinds of interruptions, but [they] also occasionally gets clues as to what the world is and what might be important.” — Richard Hamming

This [Quartz](https://quartz.jzhao.xyz/) fork is for publishing my Today I Learned blog at <https://til.maroukis.net>. It's meant to be a low barrier way to publish micro blog posts about what I'm working on, which works with my notetaking editor of choice [Obsidian](https://obsidian.md).


## Notes to Self

### Building

Source markdown is included as a submodule in `/content`. In this directory pull changes from `til-source main` and checkout the `til-source quartz/publish` branch. Then merge changes from `main`→`publish` and build the new `/content/index.md` file with the scripts in `/_userscripts`. 

Then back in the `/` directory push the `/content` changes to the `main` branch. The GH-pages site is built upon pushes to `main`.

For updating Quartz look at the `v4` branch and merge upstream changes into `main`. 

Automate all of the above into a github actions workflow upon pushes to `til-source main` to get a one touch workflow.

### Quartz Configuration

Configure in `quartz.config.ts`.
