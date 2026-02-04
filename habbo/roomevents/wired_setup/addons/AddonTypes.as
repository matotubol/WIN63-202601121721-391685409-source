package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3525;
   import com.sulake.habbo.roomevents.wired_setup.class_2403;
   import com.sulake.habbo.roomevents.wired_setup.class_2510;
   
   public class AddonTypes implements class_2510
   {
      
      private var var_57:Array = [];
      
      public function AddonTypes()
      {
         super();
         this.var_57.push(new class_3744());
         this.var_57.push(new class_3995());
         this.var_57.push(new class_3879());
         this.var_57.push(new class_4004());
         this.var_57.push(new NoMoveAnimation());
         this.var_57.push(new class_4035());
         this.var_57.push(new CarryUsers());
         this.var_57.push(new AnimationTime());
         this.var_57.push(new class_3678());
         this.var_57.push(new class_3974());
         this.var_57.push(new class_3873());
         this.var_57.push(new class_3776());
         this.var_57.push(new class_3990());
         this.var_57.push(new class_3863());
         this.var_57.push(new class_3739());
         this.var_57.push(new class_3783());
         this.var_57.push(new class_3877());
         this.var_57.push(new class_3833());
         this.var_57.push(new class_4021());
         this.var_57.push(new GlobalPlaceholderAddon());
      }
      
      public function getElementByCode(param1:int) : class_2403
      {
         for each(var _loc2_ in var_57)
         {
            if(_loc2_.code == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getKey() : String
      {
         return "addon";
      }
      
      public function acceptTriggerable(param1:class_2397) : Boolean
      {
         return param1 as class_3525 != null;
      }
   }
}

