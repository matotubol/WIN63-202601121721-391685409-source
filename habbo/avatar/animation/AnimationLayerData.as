package com.sulake.habbo.avatar.animation
{
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.avatar.actions.ActiveActionData;
   import com.sulake.habbo.avatar.actions.class_2501;
   import com.sulake.habbo.avatar.actions.class_2768;
   
   public class AnimationLayerData implements class_2314
   {
      
      public static const const_930:String = "bodypart";
      
      public static const const_891:String = "fx";
      
      private var var_197:String;
      
      private var _action:class_2501;
      
      private var _animationFrame:int;
      
      private var var_3286:int;
      
      private var var_3229:int;
      
      private var var_3162:int;
      
      private var _directionOffset:int;
      
      private var var_230:String;
      
      private var var_2399:String;
      
      private var _items:class_55 = new class_55();
      
      public function AnimationLayerData(param1:XML, param2:String, param3:class_2768)
      {
         super();
         var_197 = String(param1.@id);
         _animationFrame = parseInt(param1.@frame);
         var_3286 = parseInt(param1.@dx);
         var_3229 = parseInt(param1.@dy);
         var_3162 = parseInt(param1.@dz);
         _directionOffset = parseInt(param1.@dd);
         var_230 = param2;
         var_2399 = String(param1.@base);
         for each(var _loc5_ in param1.item)
         {
            _items[String(_loc5_.@id)] = String(_loc5_.@base);
         }
         var _loc4_:String = "";
         if(var_2399 != "")
         {
            _loc4_ = String(baseAsInt());
         }
         if(param3 != null)
         {
            _action = new ActiveActionData(param3.state,base);
            _action.definition = param3;
         }
      }
      
      public function get items() : class_55
      {
         return _items;
      }
      
      private function baseAsInt() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < var_2399.length)
         {
            _loc2_ += var_2399.charCodeAt(_loc1_);
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function get id() : String
      {
         return var_197;
      }
      
      public function get animationFrame() : int
      {
         return _animationFrame;
      }
      
      public function get dx() : int
      {
         return var_3286;
      }
      
      public function get dy() : int
      {
         return var_3229;
      }
      
      public function get dz() : int
      {
         return var_3162;
      }
      
      public function get directionOffset() : int
      {
         return _directionOffset;
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function get base() : String
      {
         return var_2399;
      }
      
      public function get action() : class_2501
      {
         return _action;
      }
   }
}

