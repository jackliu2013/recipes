#include <stdio.h>
#include <stdlib.h>

#include <queue.h>

#define NAMESIZE 32
struct score {
      int id;
      char name[NAMESIZE];
};

struct node {
      struct score data;
      struct node *l, *r;
};

struct node *tree = NULL;

void print_s(struct score *data)
{
      printf("%d %s\n", data->id, data->name);
}

#if 0
int insert(struct node **root, struct score *data)
{
      if (*root == NULL) {
	    *root = malloc(sizeof(struct node));
	    if (*root == NULL) {
		  return -1;
	    }
	    (*root)->data = *data;
	    (*root)->l = (*root)->r = NULL;
	    return 0;
      }

      if (data->id <= (*root)->data.id) {
	    return insert(&(*root)->l, data);
      } else {
	    return insert(&(*root)->r, data);
      }
}
#else
int insert(struct node **root, struct score *data)
{
      struct node *newnode;

      newnode = malloc(sizeof(struct node));
      if (newnode == NULL) {
	    return -1;
      }
      newnode->data = *data;
      newnode->l = newnode->r = NULL;

      while (1) {
	    if (*root == NULL) {
		  *root = newnode;
		  break;
	    }

	    if (data->id <= (*root)->data.id) {
		  root = &(*root)->l;
	    } else {
		  root = &(*root)->r;
	    }
      }

      return 0;
}
#endif

#if 0
struct score *find(struct node *root, int id)
{
      if (root == NULL) {
	    return NULL;
      }

      if (id == root->data.id) {
	    return &root->data;
      } else if (id < root->data.id) {
	    return find(root->l, id);
      } else {
	    return find(root->r, id);
      }
}
#else
struct score *find(struct node *root, int id)
{
      while (1) {
	    if (root == NULL) {
		  return NULL;
	    }

	    if (id == root->data.id) {
		  break;
	    } else if (id < root->data.id) {
		  root = root->l;
	    } else {
		  root = root->r;
	    }
      }
      return &root->data;
}
#endif

void travel(struct node *root)
{
      if (root == NULL) {
	    return;
      }

      travel(root->l);
      travel(root->r);

      print_s(&root->data);
}

void travel_breadth(struct node *root)
{
      QUEUE *q;
      struct node *cur;
      int ret;

      q = queue_creat(sizeof(struct node *));
      /* if error */

      queue_en(q, &root);
      /* if error */
      while (1) {
	    ret = queue_de(q, &cur);
	    if (ret == -1) {
		  break;
	    }

	    print_s(&cur->data);
	    if (cur->l != NULL) {
		  queue_en(q, &cur->l);
		  /* if error */
	    }
	    if (cur->r != NULL) {
		  queue_en(q, &cur->r);
		  /* if error */
	    }
      }

      queue_destroy(q);
}

static void __draw(struct node *root, int level)
{
      int i;

      if (root == NULL) {
            return;
      }

      __draw(root->r, level + 1);

      for (i = 0; i < level; i++) {
	    printf("     ");
      }
      print_s(&root->data);

      __draw(root->l, level + 1);
}

void draw(struct node *root)
{
      __draw(root, 0);
      getchar();
}

static struct node *__find_max(struct node *root)
{
      struct node *cur;

      for (cur = root; cur->r != NULL; cur = cur->r)
	    ;
      return cur;
}

static struct node *__find_min(struct node *root)
{
      struct node *cur;

      for (cur = root; cur->l != NULL; cur = cur->l)
	    ;
      return cur;
}

#if 0
void delete(struct node **root, int id)
{
      struct node *cur;

      if (*root == NULL) {
	    return;
      }
      if (id == (*root)->data.id) {
	    cur = *root;
	    if (cur->l == NULL) {
		  *root = cur->r;
	    } else {
		  *root = cur->l;
		  __find_max(cur->l)->r = cur->r;
	    }
	    free(cur);
      } else if (id < (*root)->data.id) {
	    delete(&(*root)->l, id);
      } else {
	    delete(&(*root)->r, id);
      }
}
#elif 0
void delete(struct node **root, int id)
{
      struct node *cur;

      while (1) {
	    if (*root == NULL) {
		  return;
	    }

	    if (id == (*root)->data.id) {
		  break;
	    } else if (id < (*root)->data.id) {
		  root = &(*root)->l;
	    } else {
		  root = &(*root)->r;
	    }
      }

      cur = *root;
      if (cur->l == NULL) {
	    *root = cur->r;
      } else {
	    *root = cur->l;
	    __find_max(cur->l)->r = cur->r;
      }
      free(cur);
}
#else
void delete(struct node **root, int id)
{
      struct node *cur, **truenode;

      while (1) {
	    if (*root == NULL) {
		  return;
	    }

	    if (id == (*root)->data.id) {
		  break;
	    } else if (id < (*root)->data.id) {
		  root = &(*root)->l;
	    } else {
		  root = &(*root)->r;
	    }
      }

      cur = *root;
      if ((*root)->l == NULL) {
	    *root = cur->r;
      } else if ((*root)->r == NULL) {
	    *root = cur->l;
      } else {
	    for (truenode = &cur->r; (*truenode)->l != NULL; truenode = &(*truenode)->l)
		  ;
	    cur->data = (*truenode)->data;

	    cur = *truenode;
	    *truenode = cur->r;
      }
      free(cur);
}
#endif

int get_num(struct node *root)
{
      if (root == NULL) {
	    return 0;
      }
      return get_num(root->l) + 1 + get_num(root->r);
}

static void __turn_left(struct node **root)
{
      struct node *cur;

      cur = *root;
      *root = cur->r;
      cur->r = NULL;
      __find_min(*root)->l = cur;

      //draw(tree);		/* debug */
}

static void __turn_right(struct node **root)
{
      struct node *cur;

      cur = *root;
      *root = cur->l;
      cur->l = NULL;
      __find_max(*root)->r = cur;

      //draw(tree);               /* debug */
}

void balance(struct node **root)
{
      int sub;

      if (*root == NULL) {
	    return;
      }

      while (1) {
	    sub = get_num((*root)->l) - get_num((*root)->r);
	    if (sub >= -1 && sub <= 1) {
		  balance(&(*root)->l);
		  balance(&(*root)->r);
		  return;
	    } else if (sub < -1) {
		  __turn_left(root);
	    } else {
		  __turn_right(root);
	    }
      }
}

int main(void)
{
      int arr[] = {1,2,55,66,3,33,44,4,5,99,88,6,7,8,9};
      int i;
      struct score tmp, *data;

      for (i = 0; i < sizeof(arr) / sizeof(int); i++) {
	    tmp.id = arr[i];
	    snprintf(tmp.name, NAMESIZE, "stu%d", arr[i]);

	    insert(&tree, &tmp);
      }

      balance(&tree);
      //draw(tree);
      //delete(&tree, 7);
      //delete(&tree, 8);
      draw(tree);
      travel_breadth(tree);
#if 0
      data = find(tree, 10);
      if (data == NULL) {
	    printf("Can not find.\n");
      } else {
	    print_s(data);
      }
#endif

      return 0;
}
