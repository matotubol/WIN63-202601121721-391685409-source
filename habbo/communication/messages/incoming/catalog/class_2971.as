package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2971
   {
      
      private var var_588:Boolean;
      
      private var _icon:int;
      
      private var var_2228:int;
      
      private var _pageName:String;
      
      private var _localization:String;
      
      private var _children:Vector.<class_2971>;
      
      private var _offerIds:Vector.<int>;
      
      public function class_2971(param1:IMessageDataWrapper)
      {
         super();
         var_588 = param1.readBoolean();
         _icon = param1.readInteger();
         var_2228 = param1.readInteger();
         _pageName = param1.readString();
         _localization = param1.readString();
         _offerIds = new Vector.<int>(0);
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            _offerIds.push(param1.readInteger());
            _loc3_++;
         }
         _children = new Vector.<class_2971>(0);
         var _loc4_:int = param1.readInteger();
         _loc3_ = 0;
         while(0 < _loc4_)
         {
            _children.push(new class_2971(param1));
            _loc3_++;
         }
      }
      
      public function get visible() : Boolean
      {
         return var_588;
      }
      
      public function get icon() : int
      {
         return _icon;
      }
      
      public function get pageId() : int
      {
         return var_2228;
      }
      
      public function get pageName() : String
      {
         return _pageName;
      }
      
      public function get localization() : String
      {
         return _localization;
      }
      
      public function get children() : Vector.<class_2971>
      {
         return _children;
      }
      
      public function get offerIds() : Vector.<int>
      {
         return _offerIds;
      }
   }
}

