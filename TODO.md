* Ability to run inside minitest (mocked pipes)
* bin tool to "scaffold" new handlers
* bin tool to generate api contract based on handlers
* Raising errors back to the stack (using TTID)
* figure out how to implement HTTP endpoint functionalities
  * Maybe support sinatra only? Reractor::HttpTerminator
    * This would raise caught exceptions from the stack (it would act as event terminator)
* Chunking data-store (cassnadra first) for large messages over [configurable] size