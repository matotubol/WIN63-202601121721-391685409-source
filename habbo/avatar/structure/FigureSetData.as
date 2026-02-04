package com.sulake.habbo.avatar.structure
{
   import com.sulake.habbo.avatar.structure.figure.*;
   import flash.utils.Dictionary;
   
   public class FigureSetData implements IStructureData, class_1780
   {
      
      private var var_501:Dictionary;
      
      private var var_1017:Dictionary;
      
      public function FigureSetData()
      {
         super();
         var_501 = new Dictionary();
         var_1017 = new Dictionary();
      }
      
      public function dispose() : void
      {
      }
      
      public function parse(param1:XML) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         for each(var _loc2_ in param1.colors.palette)
         {
            var_501[String(_loc2_.@id)] = new Palette(_loc2_);
         }
         for each(var _loc3_ in param1.sets.settype)
         {
            var_1017[String(_loc3_.@type)] = new SetType(_loc3_);
         }
         return true;
      }
      
      public function injectXML(param1:XML) : void
      {
         var _loc2_:SetType = null;
         for each(var _loc3_ in param1.sets.settype)
         {
            _loc2_ = var_1017[String(_loc3_.@type)];
            if(_loc2_ != null)
            {
               _loc2_.cleanUp(_loc3_);
            }
            else
            {
               var_1017[String(_loc3_.@type)] = new SetType(_loc3_);
            }
         }
         appendXML(param1);
      }
      
      public function appendXML(param1:XML) : Boolean
      {
         var _loc3_:Palette = null;
         var _loc4_:SetType = null;
         if(param1 == null)
         {
            return false;
         }
         for each(var _loc2_ in param1.colors.palette)
         {
            _loc3_ = var_501[String(_loc2_.@id)];
            if(_loc3_ == null)
            {
               var_501[String(_loc2_.@id)] = new Palette(_loc2_);
            }
            else
            {
               _loc3_.append(_loc2_);
            }
         }
         for each(var _loc5_ in param1.sets.settype)
         {
            _loc4_ = var_1017[String(_loc5_.@type)];
            if(_loc4_ == null)
            {
               var_1017[String(_loc5_.@type)] = new SetType(_loc5_);
            }
            else
            {
               _loc4_.append(_loc5_);
            }
         }
         return false;
      }
      
      public function getMandatorySetTypeIds(param1:String, param2:int) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc4_ in var_1017)
         {
            if(_loc4_ && _loc4_.isMandatory(param1,param2))
            {
               _loc3_.push(_loc4_.type);
            }
         }
         return _loc3_;
      }
      
      public function getDefaultPartSet(param1:String, param2:String) : class_1932
      {
         var _loc3_:SetType = var_1017[param1] as SetType;
         if(_loc3_)
         {
            return _loc3_.getDefaultPartSet(param2);
         }
         return null;
      }
      
      public function getSetType(param1:String) : ISetType
      {
         return var_1017[param1];
      }
      
      public function getPalette(param1:int) : class_2017
      {
         return var_501[String(param1)];
      }
      
      public function getFigurePartSet(param1:int) : class_1932
      {
         var _loc2_:class_1932 = null;
         for each(var _loc3_ in var_1017)
         {
            _loc2_ = _loc3_.getPartSet(param1);
            if(_loc2_ != null)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

