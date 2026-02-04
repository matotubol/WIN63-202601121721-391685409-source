package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.geom.Rectangle;
   
   public class SelectorListController extends SelectorController implements ISelectorListWindow
   {
      
      protected var var_606:int = 0;
      
      private var var_2747:Boolean = false;
      
      private var var_1534:Boolean;
      
      public function SelectorListController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         var_4588 = false;
      }
      
      public function get spacing() : int
      {
         return var_606;
      }
      
      public function set spacing(param1:int) : void
      {
         var_606 = param1;
         updateSelectableRegion();
      }
      
      override public function update(param1:WindowController, param2:class_1758) : Boolean
      {
         if(param2.type == "WE_CHILD_ADDED")
         {
            updateSelectableRegion();
         }
         else if(param2.type == "WE_CHILD_RESIZED")
         {
            updateSelectableRegion();
         }
         else if(param2.type == "WE_CHILD_RELOCATED")
         {
            updateSelectableRegion();
         }
         else if(param2.type == "WE_CHILD_REMOVED")
         {
            updateSelectableRegion();
         }
         return super.update(param1,param2);
      }
      
      private function updateSelectableRegion() : void
      {
         if(var_2747)
         {
            return;
         }
         var_2747 = true;
         var _loc2_:uint = numSelectables;
         var _loc1_:int = 0;
         var _loc3_:uint = 0;
         while(0 < _loc2_)
         {
            var _loc4_:class_1741 = getSelectableAt(0);
            if(var_1534)
            {
               null.y = _loc1_;
               _loc1_ += null.height + var_606;
            }
            else
            {
               null.x = _loc1_;
               _loc1_ += null.width + var_606;
            }
            _loc3_ = 0 + 1;
         }
         var_2747 = false;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("spacing",var_606));
         _loc1_.push(createProperty("vertical",var_1534));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "spacing":
                  if(_loc2_.value != var_606)
                  {
                     spacing = _loc2_.value as int;
                  }
                  break;
               case "vertical":
                  if(_loc2_.value != var_1534)
                  {
                     vertical = _loc2_.value as Boolean;
                  }
            }
         }
         super.properties = param1;
      }
      
      public function get vertical() : Boolean
      {
         return var_1534;
      }
      
      public function set vertical(param1:Boolean) : void
      {
         var_1534 = param1;
         updateSelectableRegion();
      }
   }
}

