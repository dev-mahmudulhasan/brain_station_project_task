// lib/repository_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repodata_model.dart';
import '../logic/bloc/repo_bloc.dart';
import '../logic/bloc/repo_event.dart';
import '../logic/bloc/repo_state.dart';
import 'repository_details_screen.dart';

class RepositoryListScreen extends StatefulWidget {
  @override
  _RepositoryListScreenState createState() => _RepositoryListScreenState();
}

class _RepositoryListScreenState extends State<RepositoryListScreen> {
  final ScrollController _scrollController = ScrollController();
  final int _perPage = 10;
  int _currentPage = 1;
  bool _isLoading = false;
  List<Repository> _repositories = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchRepositories();
  }

  void _fetchRepositories() {
    if (_isLoading) return;

    _isLoading = true;
    context.read<RepositoryBloc>().add(FetchRepositories('flutter', _currentPage, _perPage));
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        _currentPage++;
        _fetchRepositories();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Repository Explorer'),
      ),
      body: BlocConsumer<RepositoryBloc, RepositoryState>(
        listener: (context, state) {
          if (state is RepositoryLoaded) {
            setState(() {
              _isLoading = false;
              _repositories.addAll(state.repositories);
            });
          }
        },
        builder: (context, state) {
          if (state is RepositoryInitial || state is RepositoryLoading && _repositories.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RepositoryError) {
            return Center(child: Text('Failed to fetch repositories: ${state.message}'));
          } else {
            return ListView.builder(
              controller: _scrollController,
              itemCount: _repositories.length + 1,
              itemBuilder: (context, index) {
                if (index == _repositories.length) {
                  return _isLoading ? Center(child: CircularProgressIndicator()) : SizedBox.shrink();
                }
                final repo = _repositories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: ListTile(
                     contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      leading: Padding(
                        padding: EdgeInsets.only(top: 16,),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey.shade200,
                          child: Icon(Icons.person, color: Colors.grey.shade700, size: 25),
                        ),
                      ),
                      title: Text(
                        repo.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              SizedBox(width: 5),
                              Text('${repo.stargazersCount}', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.person, color: Colors.grey, size: 20),
                              SizedBox(width: 5),
                              Text(repo.owner, style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Updated on: ${repo.lastUpdated}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RepositoryDetailScreen(repository: repo),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
