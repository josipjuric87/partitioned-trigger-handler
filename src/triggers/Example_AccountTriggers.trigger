trigger Example_AccountTriggers on Account (after update) {

    new Example_AccountTriggerHandler().handleTrigger();

}