package com.sulake.habbo.inventory.effects
{
   import com.sulake.habbo.avatar.class_2972;
   import com.sulake.habbo.inventory.IThumbListDrawableItem;
   import com.sulake.habbo.inventory.class_1777;
   import com.sulake.habbo.ui.widget.memenu.class_2303;
   import flash.display.BitmapData;
   
   public class Effect implements class_2303, IThumbListDrawableItem, class_2972, class_1777
   {
      
      private var var_230:int;
      
      private var var_3316:int;
      
      private var var_2740:int;
      
      private var var_1444:int = 1;
      
      private var var_2376:int;
      
      private var var_3835:Boolean = false;
      
      private var var_1037:Boolean = false;
      
      private var var_2281:Boolean = false;
      
      private var var_2983:Boolean = false;
      
      private var var_952:BitmapData;
      
      private var var_4662:Date;
      
      public function Effect()
      {
         super();
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get subType() : int
      {
         return var_3316;
      }
      
      public function get duration() : int
      {
         return var_2740;
      }
      
      public function get amountInInventory() : int
      {
         return var_1444;
      }
      
      public function get isPermanent() : Boolean
      {
         return var_3835;
      }
      
      public function get isActive() : Boolean
      {
         return var_1037;
      }
      
      public function get isInUse() : Boolean
      {
         return var_2983;
      }
      
      public function get isSelected() : Boolean
      {
         return var_2281;
      }
      
      public function get icon() : BitmapData
      {
         return var_952;
      }
      
      public function get iconImage() : BitmapData
      {
         return var_952;
      }
      
      public function get secondsLeft() : int
      {
         var _loc1_:int = 0;
         if(var_1037)
         {
            _loc1_ = var_2376 - (new Date().valueOf() - var_4662.valueOf()) / 1000;
            _loc1_ = Math.floor(_loc1_);
            if(_loc1_ < 0)
            {
               _loc1_ = 0;
            }
            return _loc1_;
         }
         return var_2376;
      }
      
      public function set type(param1:int) : void
      {
         var_230 = param1;
      }
      
      public function set subType(param1:int) : void
      {
         var_3316 = param1;
      }
      
      public function set duration(param1:int) : void
      {
         var_2740 = param1;
      }
      
      public function set secondsLeft(param1:int) : void
      {
         var_2376 = param1;
      }
      
      public function set isPermanent(param1:Boolean) : void
      {
         var_3835 = param1;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         var_2281 = param1;
      }
      
      public function set isInUse(param1:Boolean) : void
      {
         var_2983 = param1;
      }
      
      public function set iconImage(param1:BitmapData) : void
      {
         var_952 = param1;
      }
      
      public function set amountInInventory(param1:int) : void
      {
         var_1444 = param1;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         if(param1 && !var_1037)
         {
            var_4662 = new Date();
         }
         var_1037 = param1;
      }
      
      public function setOneEffectExpired() : void
      {
         var_1444 = var_1444 - 1;
         if(var_1444 < 0)
         {
            var_1444 = 0;
         }
         var_2376 = var_2740;
         var_1037 = false;
         var_2983 = false;
      }
   }
}

