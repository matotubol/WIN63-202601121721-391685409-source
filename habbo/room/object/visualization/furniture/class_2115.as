package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.core.assets.class_40;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   
   public class class_2115 implements IRoomObjectVisualizationData
   {
      
      private var _assets:class_40;
      
      public function class_2115()
      {
         super();
      }
      
      public function dispose() : void
      {
         _assets = null;
      }
      
      public function initialize(param1:XML) : Boolean
      {
         return true;
      }
      
      public function set assets(param1:class_40) : void
      {
         _assets = param1;
      }
      
      public function get assets() : class_40
      {
         return _assets;
      }
   }
}

