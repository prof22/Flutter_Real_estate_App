class SendMessageModel
{
String name;
String email;
String phone;
String message;
int agentId;
int messageCount;

toJson(){
  return {
    'agent_id':agentId.toString(),
    'name': name,
    'email': email,
    'phone':phone,
    'message':message,
  };
}
}