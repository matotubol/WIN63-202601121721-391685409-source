package com.sulake.habbo.catalog.recycler
{
   public interface IRecycler
   {
      
      function init(param1:IRecyclerVisualization = null) : void;
      
      function cancel() : void;
      
      function empty() : void;
      
      function getSlotContent(param1:int) : FurniSlotItem;
      
      function placeObjectAtSlot(param1:int, param2:int, param3:int, param4:int, param5:String, param6:Boolean = false) : void;
      
      function releaseSlot(param1:int) : void;
      
      function executeRecycler() : void;
      
      function isReadyToRecycle() : Boolean;
      
      function hasEnoughDuckets() : Boolean;
      
      function get timeout() : int;
      
      function get ducketCost() : int;
      
      function getPrizeTable(param1:Function) : Array;
      
      function get numberOfSlots() : int;
      
      function secondsToWait() : int;
      
      function get recyclerDisabled() : Boolean;
      
      function setNextRecycleAllowedTimestamp(param1:int) : void;
   }
}

