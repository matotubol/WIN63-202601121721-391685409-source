package com.sulake.habbo.inventory
{
   public interface class_1954
   {
      
      function resetCategory(param1:int) : Boolean;
      
      function resetItems(param1:int, param2:Array) : Boolean;
      
      function resetCategoryIfEmpty(param1:int) : Boolean;
      
      function isUnseen(param1:int, param2:int) : Boolean;
      
      function removeUnseen(param1:int, param2:int) : Boolean;
      
      function getIds(param1:int) : Array;
      
      function getCount(param1:int) : int;
      
      function setUnseenItem(param1:int, param2:int) : void;
   }
}

