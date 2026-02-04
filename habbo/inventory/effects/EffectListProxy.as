package com.sulake.habbo.inventory.effects
{
   import com.sulake.habbo.inventory.common.IThumbListDataProvider;
   
   public class EffectListProxy implements IThumbListDataProvider
   {
      
      private var var_36:EffectsModel;
      
      private var var_168:int;
      
      public function EffectListProxy(param1:EffectsModel, param2:int)
      {
         super();
         var_36 = param1;
         var_168 = param2;
      }
      
      public function dispose() : void
      {
         var_36 = null;
      }
      
      public function getDrawableList() : Array
      {
         return var_36.getEffects(var_168);
      }
   }
}

