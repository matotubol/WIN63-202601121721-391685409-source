package com.sulake.habbo.avatar.animation
{
   public class SpriteDataContainer implements ISpriteDataContainer
   {
      
      private var var_2040:class_2608;
      
      private var var_197:String;
      
      private var var_3689:int;
      
      private var var_4606:String;
      
      private var var_4772:Boolean;
      
      private var var_4897:Boolean;
      
      private var var_3286:Array;
      
      private var var_3229:Array;
      
      private var var_3162:Array;
      
      public function SpriteDataContainer(param1:class_2608, param2:XML)
      {
         super();
         var_2040 = param1;
         var_197 = String(param2.@id);
         var_3689 = parseInt(param2.@ink);
         var_4606 = String(param2.@member);
         var_4897 = Boolean(parseInt(param2.@staticY));
         var_4772 = Boolean(parseInt(param2.@directions));
         var_3286 = [];
         var_3229 = [];
         var_3162 = [];
         for each(var _loc3_ in param2.direction)
         {
            var _loc4_:int = parseInt(_loc3_.@id);
            var_3286[0] = parseInt(_loc3_.@dx);
            var_3229[0] = parseInt(_loc3_.@dy);
            var_3162[0] = parseInt(_loc3_.@dz);
         }
      }
      
      public function getDirectionOffsetX(param1:int) : int
      {
         if(param1 < var_3286.length)
         {
            return var_3286[param1];
         }
         return 0;
      }
      
      public function getDirectionOffsetY(param1:int) : int
      {
         if(param1 < var_3229.length)
         {
            return var_3229[param1];
         }
         return 0;
      }
      
      public function getDirectionOffsetZ(param1:int) : int
      {
         if(param1 < var_3162.length)
         {
            return var_3162[param1];
         }
         return 0;
      }
      
      public function get animation() : class_2608
      {
         return var_2040;
      }
      
      public function get id() : String
      {
         return var_197;
      }
      
      public function get ink() : int
      {
         return var_3689;
      }
      
      public function get member() : String
      {
         return var_4606;
      }
      
      public function get hasDirections() : Boolean
      {
         return var_4772;
      }
      
      public function get hasStaticY() : Boolean
      {
         return var_4897;
      }
   }
}

