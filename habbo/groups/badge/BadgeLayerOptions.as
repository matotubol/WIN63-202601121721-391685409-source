package com.sulake.habbo.groups.badge
{
   public class BadgeLayerOptions
   {
      
      private var var_2032:int = -1;
      
      private var var_2798:int = -1;
      
      private var var_2270:int = -1;
      
      private var var_1359:int = -1;
      
      private var var_1438:int = -1;
      
      public function BadgeLayerOptions()
      {
         super();
      }
      
      public function setGrid(param1:int) : void
      {
         var_1359 = Math.floor(param1 % 3);
         var_1438 = Math.floor(param1 / 3);
      }
      
      public function clone() : BadgeLayerOptions
      {
         var _loc1_:BadgeLayerOptions = new BadgeLayerOptions();
         _loc1_.var_2032 = var_2032;
         _loc1_.var_2798 = var_2798;
         _loc1_.var_2270 = var_2270;
         _loc1_.var_1359 = var_1359;
         _loc1_.var_1438 = var_1438;
         return _loc1_;
      }
      
      public function equalVisuals(param1:BadgeLayerOptions) : Boolean
      {
         if(param1 == null || var_1359 != param1.gridX || var_1438 != param1.gridY || var_2270 != param1.colorIndex)
         {
            return false;
         }
         if(var_2032 == 0 && param1.layerIndex != 0 || var_2032 != 0 && param1.layerIndex == 0)
         {
            return false;
         }
         return true;
      }
      
      public function isGridEqual(param1:BadgeLayerOptions) : Boolean
      {
         if(param1.gridX == var_1359 && param1.gridY == var_1438)
         {
            return true;
         }
         return false;
      }
      
      public function get layerIndex() : int
      {
         return var_2032;
      }
      
      public function set layerIndex(param1:int) : void
      {
         var_2032 = param1;
      }
      
      public function get partIndex() : int
      {
         return var_2798;
      }
      
      public function set partIndex(param1:int) : void
      {
         var_2798 = param1;
      }
      
      public function get colorIndex() : int
      {
         return var_2270;
      }
      
      public function set colorIndex(param1:int) : void
      {
         var_2270 = param1;
      }
      
      public function get gridX() : int
      {
         return var_1359;
      }
      
      public function set gridX(param1:int) : void
      {
         var_1359 = param1;
      }
      
      public function get gridY() : int
      {
         return var_1438;
      }
      
      public function set gridY(param1:int) : void
      {
         var_1438 = param1;
      }
      
      public function get position() : int
      {
         return gridY * 3 + gridX;
      }
   }
}

