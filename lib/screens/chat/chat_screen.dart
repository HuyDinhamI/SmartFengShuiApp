import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/theme.dart';
import '../../models/chat_message.dart';
import '../../providers/auth_provider.dart';
import '../../providers/chat_provider.dart';
import '../../providers/theme_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  
  bool _isComposing = false;
  
  @override
  void initState() {
    super.initState();
    
    // Tải tin nhắn khi màn hình được khởi tạo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final chatProvider = Provider.of<ChatProvider>(context, listen: false);
      chatProvider.loadMessages();
    });
  }
  
  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
  
  // Cuộn xuống dưới cùng sau khi gửi tin nhắn
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final chatProvider = Provider.of<ChatProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot Phong Thủy'),
        centerTitle: true,
        actions: [
          // Theme toggle
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              themeProvider.toggleThemeMode();
            },
          ),
          // Menu
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'clear':
                  _showClearChatDialog(context);
                  break;
                case 'help':
                  _showHelpDialog(context);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear',
                child: ListTile(
                  leading: Icon(Icons.delete_outline),
                  title: Text('Xóa lịch sử chat'),
                ),
              ),
              const PopupMenuItem(
                value: 'help',
                child: ListTile(
                  leading: Icon(Icons.help_outline),
                  title: Text('Trợ giúp'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: chatProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : chatProvider.messages.isEmpty
                  ? _buildEmptyChat()
                  : _buildChatMessages(context),
          ),
          
          // Input box
          _buildMessageComposer(context),
        ],
      ),
    );
  }
  
  // Widget hiển thị khi chưa có tin nhắn nào
  Widget _buildEmptyChat() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 80,
            color: AppTheme.primaryColor.withOpacity(0.5),
          ),
          const SizedBox(height: AppTheme.spacingMedium),
          const Text(
            'Chào mừng đến với Chatbot Phong Thủy',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spacingSmall),
          const Text(
            'Hãy đặt câu hỏi để nhận tư vấn phong thủy',
            style: TextStyle(
              color: AppTheme.mediumGray,
            ),
          ),
          const SizedBox(height: AppTheme.spacingLarge),
          ElevatedButton.icon(
            onPressed: () {
              // Gợi ý một câu hỏi ban đầu
              _messageController.text = 'Các nguyên tắc phong thủy cơ bản là gì?';
              setState(() {
                _isComposing = true;
              });
              _focusNode.requestFocus();
            },
            icon: const Icon(Icons.lightbulb_outline),
            label: const Text('Đặt câu hỏi gợi ý'),
          ),
        ],
      ),
    );
  }
  
  // Widget hiển thị danh sách tin nhắn
  Widget _buildChatMessages(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (chatProvider.messages.isNotEmpty) {
        _scrollToBottom();
      }
    });
    
    return ListView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        vertical: AppTheme.spacingMedium,
        horizontal: AppTheme.spacingMedium,
      ),
      itemCount: chatProvider.messages.length,
      itemBuilder: (context, index) {
        final message = chatProvider.messages[index];
        return _buildChatBubble(context, message);
      },
    );
  }
  
  // Widget hiển thị từng tin nhắn
  Widget _buildChatBubble(BuildContext context, ChatMessage message) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    
    // Màu sắc tin nhắn
    final botBubbleColor = isDarkMode
        ? AppTheme.darkElevatedColor
        : AppTheme.lightGray;
    
    final userBubbleColor = isDarkMode
        ? AppTheme.primaryColor.withOpacity(0.7)
        : AppTheme.primaryColor;
    
    final botTextColor = message.error
        ? AppTheme.errorColor
        : isDarkMode
            ? AppTheme.lightTextColor
            : AppTheme.darkTextColor;
    
    final userTextColor = Colors.white;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSmall),
      child: Row(
        mainAxisAlignment: message.isBot
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bot icon
          if (message.isBot) ...[
            CircleAvatar(
              backgroundColor: AppTheme.primaryColor,
              radius: 16,
              child: const Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: AppTheme.spacingSmall),
          ],
          
          // Message bubble
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMedium, 
                vertical: AppTheme.spacingMedium,
              ),
              decoration: BoxDecoration(
                color: message.isBot ? botBubbleColor : userBubbleColor,
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
              ),
              child: Text(
                message.content,
                style: TextStyle(
                  color: message.isBot ? botTextColor : userTextColor,
                ),
              ),
            ),
          ),
          
          // User icon
          if (!message.isBot) ...[
            const SizedBox(width: AppTheme.spacingSmall),
            CircleAvatar(
              backgroundColor: AppTheme.secondaryColor,
              radius: 16,
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ],
      ),
    );
  }
  
  // Widget ô nhập tin nhắn
  Widget _buildMessageComposer(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final chatProvider = Provider.of<ChatProvider>(context);
    
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      decoration: BoxDecoration(
        color: isDarkMode ? AppTheme.darkCardColor : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Suggestion button
            IconButton(
              icon: Icon(
                Icons.lightbulb_outline,
                color: AppTheme.secondaryColor,
              ),
              onPressed: () {
                _showSuggestionsDialog(context);
              },
            ),
            // Text field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: isDarkMode ? AppTheme.darkElevatedColor : AppTheme.lightGray,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
                ),
                child: TextField(
                  controller: _messageController,
                  focusNode: _focusNode,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.send,
                  maxLines: 3,
                  minLines: 1,
                  decoration: const InputDecoration(
                    hintText: 'Nhập tin nhắn...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMedium,
                      vertical: AppTheme.spacingSmall,
                    ),
                  ),
                  onChanged: (text) {
                    setState(() {
                      _isComposing = text.trim().isNotEmpty;
                    });
                  },
                  onSubmitted: _isComposing ? (value) => _sendMessage() : null,
                ),
              ),
            ),
            // Send button
            IconButton(
              icon: Icon(
                Icons.send,
                color: _isComposing
                    ? AppTheme.primaryColor
                    : isDarkMode
                        ? AppTheme.mediumGray
                        : AppTheme.lightGray,
              ),
              onPressed: _isComposing 
                  ? chatProvider.isGenerating
                      ? null 
                      : _sendMessage
                  : null,
            ),
          ],
        ),
      ),
    );
  }
  
  // Gửi tin nhắn
  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) {
      return;
    }
    
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    chatProvider.sendMessage(text);
    
    // Xóa nội dung và reset trạng thái
    _messageController.clear();
    setState(() {
      _isComposing = false;
    });
    
    // Cuộn xuống để xem tin nhắn mới
    _scrollToBottom();
  }
  
  // Hiển thị dialog gợi ý câu hỏi
  void _showSuggestionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Gợi ý câu hỏi'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSuggestionItem(
                  context,
                  'Phong thủy phòng khách cần chú ý những gì?',
                ),
                _buildSuggestionItem(
                  context,
                  'Cách bố trí giường ngủ hợp phong thủy?',
                ),
                _buildSuggestionItem(
                  context,
                  'Màu sắc phòng làm việc hợp mệnh Kim?',
                ),
                _buildSuggestionItem(
                  context,
                  'Các loại cây phong thủy thu hút tài lộc?',
                ),
                _buildSuggestionItem(
                  context,
                  'Cách đặt bể cá trong nhà để hút tài lộc?',
                ),
                _buildSuggestionItem(
                  context,
                  'Những điều cấm kỵ trong phong thủy nhà ở?',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }
  
  // Widget item gợi ý câu hỏi
  Widget _buildSuggestionItem(BuildContext context, String question) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        _messageController.text = question;
        setState(() {
          _isComposing = true;
        });
        _focusNode.requestFocus();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            const Icon(Icons.question_answer, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(question)),
          ],
        ),
      ),
    );
  }
  
  // Hiển thị dialog xóa lịch sử chat
  void _showClearChatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xóa lịch sử chat'),
          content: const Text(
            'Bạn có chắc muốn xóa toàn bộ lịch sử chat? Hành động này không thể hoàn tác.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                final chatProvider = Provider.of<ChatProvider>(
                  context, 
                  listen: false,
                );
                chatProvider.clearChatHistory();
                Navigator.of(context).pop();
              },
              child: const Text('Xóa'),
            ),
          ],
        );
      },
    );
  }
  
  // Hiển thị dialog trợ giúp
  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Trợ giúp Chatbot'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Chatbot phong thủy có thể giúp bạn:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('• Tư vấn về phong thủy nhà ở'),
                Text('• Gợi ý cách bố trí nội thất'),
                Text('• Chọn màu sắc hợp mệnh'),
                Text('• Tư vấn về vật phẩm phong thủy'),
                Text('• Giải đáp cách hóa giải các vấn đề phong thủy'),
                SizedBox(height: 16),
                Text(
                  'Mẹo sử dụng:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('• Đặt câu hỏi cụ thể để nhận câu trả lời chính xác'),
                Text('• Sử dụng gợi ý câu hỏi nếu bạn chưa biết hỏi gì'),
                Text('• Mỗi phiên trò chuyện được lưu lại để bạn có thể xem lại sau này'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }
}
