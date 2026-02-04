package com.sulake.habbo.catalog.recycler
{
   public interface IRecyclerVisualization
   {
      
      function updateUI() : void;
      
      function updateSlots() : void;
      
      function updateRecycleButton() : void;
      
      function get disposed() : Boolean;
   }
}

